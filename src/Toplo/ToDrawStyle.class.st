"
! Draw property (`ToDrawStyle`)

Draw properties control how the component (morph) will be draw.
I keep this properties: 

- color: foreground color for the morph if it applies (if the morph understands #color:).
- backgroundColor: background color if it applies (if the morph understands #backgroundColor:).

See `ToDrawStyle>>#color` and `ToDrawStyle>>#backgroundColor`

## Usage
The identifier of draw in the stylesheet is `Draw`.

```
Draw { 
	#color: #red,
	#backgroundColor: '00FF00'
}
```
"
Class {
	#name : #ToDrawStyle,
	#superclass : #ToPropertyStyle,
	#instVars : [
		'color',
		'backgroundColor'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'ston-core' }
ToDrawStyle class >> stonName [

	^ 'Draw'
]

{ #category : #operations }
ToDrawStyle >> applyTo: aWidget [ 

	self color ifNotNil: [ :aColor | 
		(aWidget respondsTo: #barFillStyle:)
			ifTrue: [ aWidget barFillStyle: aColor asStyleVariable valueAsColor ]
			ifFalse: [ aWidget color: aColor asStyleVariable valueAsColor ] ].
	self backgroundColor ifNotNil: [ :aColor |
		"hack to be able to decorate components that does not understand 
		 backgroundColor" 
		(aWidget respondsTo: #backgroundColor:)
			ifTrue: [ aWidget backgroundColor: aColor asStyleVariable valueAsColor ]
			ifFalse: [ aWidget fillStyle: aColor asStyleVariable valueAsColor ] ]
]

{ #category : #accessing }
ToDrawStyle >> backgroundColor [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self backgroundColorVariable value
]

{ #category : #accessing }
ToDrawStyle >> backgroundColor: aColorOrSymbol [

	backgroundColor := aColorOrSymbol asStyleVariable
]

{ #category : #'accessing - variables' }
ToDrawStyle >> backgroundColorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: backgroundColor
]

{ #category : #accessing }
ToDrawStyle >> color [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self colorVariable value
]

{ #category : #accessing }
ToDrawStyle >> color: aColorOrSymbol [

	color := aColorOrSymbol asStyleVariable
]

{ #category : #'accessing - variables' }
ToDrawStyle >> colorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: color
]
