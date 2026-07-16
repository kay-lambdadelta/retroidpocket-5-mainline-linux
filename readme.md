This contains the files required to produce a operational kernel on the Retroid Pocket 5/mini (mini untested)

The config fragment has a bare minimium set of options to ensure operation on a distro like config base config (tested once against linux upstream defconfig and actively tested against the debian defconfig)

Check the `version` file for what version we are tracking.

## Important notes

As of 7.2-rc3, there is a [serious bug](https://lore.kernel.org/all/20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com/) in `qcrypto` that _will_ cause a bootloop when it is used (for say, dm-crypt). Blacklist it.
