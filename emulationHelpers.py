import pandas as pd
import numpy as np

def readEmulationMI(home_dir="./"):

    ############### Read #########
    multiRun_dir = f"{home_dir}/CHARLES/multiRuns/"
    plotFolder = f"{multiRun_dir}"

    roomVentilationMI = pd.read_csv(f"{multiRun_dir}/roomVentilationMIEmulation.csv", index_col = [0,1])
    flowStatsMI = pd.read_csv(f"{multiRun_dir}/flowStatsMIEmulation.csv", index_col=[0,1])


    ############### Augment and normalize #########
    df = flowStatsMI.copy()
    # df = df[df["slAll"] == False]
    # normalize x_cols. Flow quantities to be normalized by WS. Pressures to be normalized by W**2:

    # df['p-noInt_optp0-q_modelC_d'] = df['p-noInt_optp0-q_model'] * df['p-noInt_optp0-C_d']
    # for col in df.columns:
    #     if "mag" in col or "shear" in col or "normal" in col:
    #         df[col] = df[col] / df['p-noInt_optp0-q_modelC_d']

    df["skylight"] = df['openingType'].apply(lambda x: 1 if "skylight" in x else 0)
    df["cross"] = df['openingType'].apply(lambda x: 1 if "cross" in x else 0)
    df["single"] = df['openingType'].apply(lambda x: 1 if "single" in x else 0)
    df["dual"] = df['openingType'].apply(lambda x: 1 if "dual" in x else 0)
    df["corner"] = df['openingType'].apply(lambda x: 1 if "corner" in x else 0)
    Sdelp = np.sign(df['p-noInt_optp0-q_model'])
    Sdelp[Sdelp == 0] = 1  # Assign 1 to zero values
    df["Sdelp"] = Sdelp
    df["EP_shear-noInt-qIn"] = df["EP_shear-noInt"] * df["Sdelp"] > 0
    df["EP_shear-noInt-qOut"] = df["EP_shear-noInt"] * df["Sdelp"] <= 0
    df["EP_shear_o_qmodel"] = df["EP_shear-noInt"] / df["p-noInt_optp0-q_model"]
    df["rev-mass_flux"] =df["net-mass_flux"] -  df["mean-mass_flux"].abs()
    df["rev-mass_flux-Norm"] = df["rev-mass_flux"] / df["WS"]
    df["p_intensity-noInt"] = df["p_rms-noInt"] / df["p-noInt_optp0-q_model"]**2

    p_norm_cols = []
    u_norm_cols = []
    no_norm_cols = []
    for col in df.columns:
        if ("noInt" in col or col == "flux" or "EP" in col) and "Norm" not in col:
            if "-p0" in col or "p_" in col or "(p)" in col or "p0meas" in col or "u**2" in col:
                p_norm_cols.append(col)
            elif "mag" in col or "shear" in col or "normal" in col or "flux" in col or "(u" in col or "q_model" in col:
                u_norm_cols.append(col)
            else:
                no_norm_cols.append(col)

    print(f"Normalizing p cols: {sorted(p_norm_cols)}")
    print(f"Normalizing u cols: {sorted(u_norm_cols)}")
    print(f"Not normalizing cols: {sorted(no_norm_cols)}")

    # Normalize pressure columns by WS^2
    for col in p_norm_cols:
        df[f"{col}-Norm"] = df[col].div(df["WS"]**2, axis=0)
    # Normalize velocity columns by WS
    for col in u_norm_cols:
        df[f"{col}-Norm"] = df[col].div(df["WS"], axis=0)

    
    roomVentilationMI["flux-Norm"] = roomVentilationMI["flux"] / roomVentilationMI["WS"]
    roomVentilationMI["p-noInt_optp0-q_model-Norm"] = roomVentilationMI["p-noInt_optp0-q_model"] / roomVentilationMI["WS"]    


    grouped = df.groupby("WS").mean(numeric_only=True)
    ratio = grouped.loc[4] / grouped.loc[2]  # Should be about 4x difference`
    ratio = pd.DataFrame(ratio).reset_index()
    print(f"Ratio of grouped means: {ratio}")

    # Removing single sided no skylights
    print("Removing single sided no skylight rooms...")
    df = df[~((df["roomType"] == "single") & (df["slAll"] == False))]  # remove single rooms without skylights
    roomVentilationMI = roomVentilationMI[~((roomVentilationMI["roomType"] == "single") & (roomVentilationMI["slAll"] == False))]  # remove single rooms without skylights

    df["all"] = True

    return df, roomVentilationMI