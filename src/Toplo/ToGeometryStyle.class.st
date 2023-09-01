"
# Geometry properties (`ToGeometryStyle`)

Geometry properties controls how the component (morph) will be arranged within its layout.

- hResizing: the component can be resized horizontally? (boolean, default depends on how the morph behaves outside spec)
- vResizing: the component can be resized vertically? (boolean, default depends on how the morph behaves outside spec)
- width: fixed width of the component.
- height: fixed height of the component.
- minWidth: minimum width of the component (to use when `hResizing=true`) 
- minHeight: minimum height of the component (to use when `vResizing=true`) 
- maxWidth: maximum width of the component (to use when `hResizing=true`) 
- maxHeight: maximum height of the component (to use when `vResizing=true`) 

## Usage
The identifier of geometry in the stylesheet is `Geometry`.

```
Geometry { 
	#hResizing: false,
	#vResizing: false,
	#width: 100,
	#height: 25,
	#minWidth: 50,
	#minHeight: 25,
	#maxWidth: 150,
	#maxHeight: 25
}
```
"
Class {
	#name : #ToGeometryStyle,
	#superclass : #ToPropertyStyle,
	#instVars : [
		'width',
		'height',
		'minWidth',
		'minHeight',
		'hResizing',
		'vResizing'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'ston-core' }
ToGeometryStyle class >> stonName [
	
	^ 'Geometry'
]

{ #category : #operations }
ToGeometryStyle >> applyTo: aWidget [

	(self widthVariable preferredScaledValueWith: aWidget width) 
		ifNotNil: [ :aNumber | aWidget width: aNumber ].
	(self heightVariable preferredScaledValueWith: aWidget height) 
		ifNotNil: [ :aNumber | aWidget height: aNumber ].
	self minWidthVariable
		ifNotNil: [ :aVariable | aWidget minWidth: aVariable scaledValue ].
	self minHeightVariable
		ifNotNil: [ :aVariable | aWidget minHeight: aVariable scaledValue ].
	self hResizingVariable 
		ifNotNil: [ :aVariable | aWidget hResizing: (self resizingStringFor: aVariable value) ].
	self vResizingVariable 
		ifNotNil: [ :aVariable | aWidget vResizing: (self resizingStringFor: aVariable value) ]
]

{ #category : #private }
ToGeometryStyle >> geometryValueBetween: baseNumber and: otherNumber [

	^ baseNumber = 0 
		ifTrue: [ otherNumber ]
		ifFalse: [ baseNumber ]
]

{ #category : #accessing }
ToGeometryStyle >> hResizing [

	^ self hResizingVariable value
]

{ #category : #accessing }
ToGeometryStyle >> hResizing: aBoolean [

	hResizing := aBoolean asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> hResizingVariable [

	^ self toVariable: hResizing
]

{ #category : #accessing }
ToGeometryStyle >> height [

	^ self heightVariable scaledValue
]

{ #category : #accessing }
ToGeometryStyle >> height: aNumber [
	
	height := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> heightVariable [

	^ self toVariable: (height ifNil: [ 0 ])
]

{ #category : #testing }
ToGeometryStyle >> isGeometry [

	^ true
]

{ #category : #accessing }
ToGeometryStyle >> minHeight [

	^ self minHeightVariable
		ifNotNil: [ :aVariable | aVariable scaledValue ]
		ifNil: [ 0 ]	
]

{ #category : #accessing }
ToGeometryStyle >> minHeight: aNumber [
	
	minHeight := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> minHeightVariable [

	^ self toVariable: minHeight
]

{ #category : #accessing }
ToGeometryStyle >> minWidth [

	^ self minWidthVariable 
		ifNotNil: [ :aVariable | aVariable scaledValue ]
		ifNil: [ 0 ]
]

{ #category : #accessing }
ToGeometryStyle >> minWidth: aNumber [

	minWidth := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> minWidthVariable [

	^ self toVariable: minWidth
]

{ #category : #private }
ToGeometryStyle >> resizingStringFor: expand [

	^ expand
		ifTrue: [ #spaceFill ]
		ifFalse: [ #rigid ]
]

{ #category : #accessing }
ToGeometryStyle >> vResizing [

	^ self vResizingVariable value
]

{ #category : #accessing }
ToGeometryStyle >> vResizing: aBoolean [

	vResizing := aBoolean asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> vResizingVariable [

	^ self toVariable: vResizing
]

{ #category : #accessing }
ToGeometryStyle >> width [

	^ self widthVariable scaledValue
]

{ #category : #accessing }
ToGeometryStyle >> width: aNumber [

	width := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToGeometryStyle >> widthVariable [

	^ self toVariable: (width ifNil: [ 0 ])
]
