#!/usr/bin/env python

import keyring

def get_keychain_pass(account):
    return keyring.get_password("mail", account)
