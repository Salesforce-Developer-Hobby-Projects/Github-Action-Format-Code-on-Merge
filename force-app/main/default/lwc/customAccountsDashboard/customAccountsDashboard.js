// AccountDashboard.js
import { LightningElement, track, 
  wire } from "lwc";

import getAccounts 
from "@salesforce/apex/AccountController.getAllAccounts";

import searchAccounts from 
"@salesforce/apex/AccountController.getAccountsByName";

import 
createAccount from "@salesforce/apex/AccountController.createAccount";

import deleteAccount from "@salesforce/apex/AccountController.deleteAccount";

export default 
class AccountDashboard extends LightningElement 
{
    @track searchTerm = '';

  @track newAccountName = "";

  @track accounts = [];

  connectedCallback() 
  {
    this.loadAccounts();
  }

  loadAccounts() 
  {
    getAccounts()
      .then((
        result
      ) => {
        this.accounts = result || [];
      })
      .catch((error) => {
        console.error(error);
      });
  }

  handleSearchChange(event) {
    this.searchTerm = event.target.value;
    this.searchAccounts();
  }

  searchAccounts() {
    searchAccounts({ name: this.searchTerm })
      .then((result) => {
        this.accounts = result || [];
      })
      .catch((error) => {
        console.error(error);
      });
  }

  handleNameChange(event) {
    this.newAccountName = event.target.value;
  }

  handleCreate() {
    createAccount({ name: this.newAccountName })
      .then(() => {
        this.newAccountName = "";
        this.loadAccounts();
      })
      .catch((error) => {
        console.error(error);
      });
  }

    handleDelete(event) {
        const accountId = event.target.dataset.accountId;
        deleteAccount({ accountId })
            .then(() => {
                this.loadAccounts();
            })
            .catch(error => {
                console.error(error);
            });
    }
}
