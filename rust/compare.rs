fn main() {
    let this_feature: &[u8; 3] = &[0, 0, 0];
    let families: &[u8] = &[0, 1];
    let features: &[u8] = &[1, 2];
    let res: bool = check_this_feature(this_feature, families, features);
    println!("{}", res);
}

fn check_this_feature(this_feature: &[u8; 3], families: &[u8], features: &[u8]) -> bool {
    let have_feature: &bool = &have(this_feature);
    let family_in: &bool = &family_included(this_feature, families);
    if have_feature && family_in {
        return features.contains(&this_feature[1]);
    } else if !have_feature && family_in {
        return !features.contains(&this_feature[1]);
    } else {
        return true
    }
}

fn have(this_feature: &[u8; 3]) -> bool {
    return this_feature[2] == 0;
}

fn family_included(this_feature: &[u8; 3], families: &[u8]) -> bool {
    return families.contains(&this_feature[0]);
}

// Compile command: rustc -o compare compare.rs;