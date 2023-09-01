"
# Container properties (`ToContainerStyle`)

A container property can be applied to container elements (buttonbar, toolbar, actionbar), and define several properties: 

- borderColor: The color of the border (in case borderWidth > 0). 
- borderWidth: The width of the border.
- padding: The space between elements.

See `ToContainerStyle>>#borderColor`

## Usage
The identifier of container in the stylesheet is`Container`.

```
Container { 
	#borderColor: #blue, 
	#borderWidth: 2,
	#padding: 5
}
```
"
Class {
	#name : #ToContainerStyle,
	#superclass : #ToPropertyStyle,
	#instVars : [
		'borderWidth',
		'padding',
		'borderColor'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'ston-core' }
ToContainerStyle class >> stonName [

	^ 'Container'
]

{ #category : #operations }
ToContainerStyle >> applyTo: aWidget [ 

	self borderColorVariable ifNotNil: [ :aVariable | aWidget borderColor: aVariable valueAsColor ].
	self borderWidthVariable ifNotNil: [ :aVariable | aWidget borderWidth: aVariable scaledValue ].
	self paddingVariable ifNotNil: [ :aVariable | aWidget cellInset: aVariable scaledValue ]
]

{ #category : #accessing }
ToContainerStyle >> borderColor [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self borderColorVariable value
]

{ #category : #accessing }
ToContainerStyle >> borderColor: aColor [

	borderColor := aColor asStyleVariable
]

{ #category : #'accessing - variables' }
ToContainerStyle >> borderColorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: borderColor
]

{ #category : #accessing }
ToContainerStyle >> borderWidth [

	^ self borderWidthVariable scaledValue
]

{ #category : #accessing }
ToContainerStyle >> borderWidth: aNumber [

	borderWidth := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToContainerStyle >> borderWidthVariable [

	^ self toVariable: borderWidth
]

{ #category : #accessing }
ToContainerStyle >> padding [

	^ self paddingVariable scaledValue
]

{ #category : #accessing }
ToContainerStyle >> padding: aNumber [

	padding := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToContainerStyle >> paddingVariable [

	^ self toVariable: padding
]
