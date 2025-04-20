Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToShrinkable',
	#classTraits : 'TToShrinkable classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #converting }
ToTabItemElement >> asString [

	^ self label asString
]

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #accessing }
ToTabItemElement >> isRemovable [

	^ removable ifNil: [ false ]
]

{ #category : #'t - triplet element - accessing' }
ToTabItemElement >> middleElement: anElement [

	super middleElement: anElement.
	"anElement addShrinkFeedbackLayerWithReferenceParent: self "
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]

{ #category : #accessing }
ToTabItemElement >> removable: aBoolean [

	removable := aBoolean
]

{ #category : #removing }
ToTabItemElement >> removeFromBar [
	" remove from bar and make sure that the next tab (or the last one) is checked after"

	| index nextChecked dataAccessor |
	self isRemovable ifFalse: [ ^ self ].
	dataAccessor := self holder listElement dataAccessor.
	index := self isChecked
		         ifTrue: [ self holder position ]
		         ifFalse: [ 0 ].
	self holder removeNodeFromBar.
	index > 0 ifFalse: [ ^ self ].
	dataAccessor ifEmpty: [ ^ self ].
	nextChecked := dataAccessor size < index
		               ifTrue: [ dataAccessor last ]
		               ifFalse: [ dataAccessor at: index ].
	nextChecked checked: true
]
