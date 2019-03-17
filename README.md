
# react-native-jwt-utils
This library provides JSON web token parser for React-Native. Only support `HS256` `HS384` `HS512` algorithm currently.

## Getting started

`$ npm install react-native-jwt-utils --save`

### Mostly automatic installation

`$ react-native link react-native-jwt-utils`

## TODO List

1. ~~Support iOS ~~ [`Finished`]
2. Support android

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [react-native-jwt-utils]`
2. Go to `node_modules` ➜ `react-native-jwt-utils` and add `RNJWT.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNJWT.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNJWTPackage;` to the imports at the top of the file
  - Add `new RNJWTPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-jwt-utils'
  	project(':react-native-jwt-utils').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-jwt-utils/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-jwt-utils')
  	```

## Usage
```javascript
import { verify } from 'react-native-jwt-utils';

const key = 'sf42t3g42g33rfsef24';
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.ighoTHFH7ZhkCMjX0JIMVrGTawxm7-eZf5U8TDIuNY8';

verify(token, key)
	.then(decodedToken => ...)
	.catch(e => ...);

```
  