# LWC Promise API

This is a small package that tends to replicate LWC backend APIs that don't support promises.

## WHY?!

That is probably the main question you may have if you stumbled across this repo. The main reason is I don't like the `@wire` decorator:

1. I hate the APIs that returns value and error as 2 output values, and you have to check that error is not empty before proceed. Just throw the goddamn error!
1. This pervious point leads to code duplication - you have to check errors for emptiness everywhere
1. When you need to load several records and you show a spinner while loading, your `isLoading` getter becomes messy.
1. `wire` cuase some of our e2e tests go flaky. Probably we just don't know how to cook it here though.
1. And the most important: `getRecord` cannot be promisified. At least I didn't found how to do it :(

## How to use it

Instead of importing `getRecord` from LWC library, you can just use `getRecord` from `sfcraft_LwcApi`:

```javascript
import getRecord from '@salesforce/apex/sfcraft_LwcApi.getRecord';

...

async connectedCallback () {
    this.record = await getRecord({recordId: this.recordId, fields: ['Id', 'Name' ]});
}
```
