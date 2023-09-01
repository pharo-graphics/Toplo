"
Environment colors can change if we change the morphic theme, in that case we need to be able to react to `themeChanged` message, which will repaint the morphic components using the new values.

To be able to react this, when declaring the usage of an environment-based color (see `ToStyleEnvironmentColorVariable`), we actually set up a proxy to a color, that will access the real color from the theme when needed.

This is used exclusively in `ToStyleEnvironmentColorVariable>>#value`
"
Class {
	#name : #ToStyleEnvironmentColorProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'colorSelector'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #converting }
ToStyleEnvironmentColorProxy >> asStyleVariable [

	^ ToStyleVariable newValue: self
]

{ #category : #accessing }
ToStyleEnvironmentColorProxy >> colorSelector: aSelector [

	colorSelector := aSelector
]

{ #category : #'reflective operations' }
ToStyleEnvironmentColorProxy >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: (Smalltalk ui theme perform: colorSelector)
]

{ #category : #hooks }
ToStyleEnvironmentColorProxy >> fuelAccept: aGeneralMapper [

	^ aGeneralMapper visitFixedObject: self 
]

{ #category : #accessing }
ToStyleEnvironmentColorProxy >> instVarAt: index [
	"Primitive. Answer a fixed variable in an object. The numbering of the variables
	 corresponds to the named instance variables, followed by the indexed instance
	 variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 173 error: ec>
	self primitiveFailed	
]

{ #category : #accessing }
ToStyleEnvironmentColorProxy >> instVarAt: index put: anObject [
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	
	self primitiveFailed
]

{ #category : #accessing }
ToStyleEnvironmentColorProxy >> yourself [
]
