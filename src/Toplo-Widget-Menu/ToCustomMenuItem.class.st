Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#instVars : [
		'innerElement',
		'builder'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToCustomMenuItem >> addedInMenuItemContainer: aMenu [

	builder value: innerElement.
	aMenu addedCustomMenuItem: self

]

{ #category : #accessing }
ToCustomMenuItem >> builder: aValuable [
	" aValuable takes the inner element as argument "
	builder := aValuable
]

{ #category : #initialization }
ToCustomMenuItem >> initialize [ 

	super initialize.
	innerElement := ToPane horizontal.
	innerElement withNullSkin.
	self addChild: innerElement.
	builder := [ :e | ]
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]
