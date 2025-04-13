Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToRemovableItemElement + TToShrinkable',
	#classTraits : 'TToRemovableItemElement classTrait + TToShrinkable classTrait',
	#instVars : [
		'removeButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - removable item element' }
ToTabItemElement >> addRemoveButton [

	removeButton ifNotNil: [ ^ self ].
	removeButton := ToIconicRemoveButton new.
	removeButton constraintsDo: [ :c |
		c ignoreByLayout ].
	self addChild: removeButton
]

{ #category : #converting }
ToTabItemElement >> asString [

	^ self label asString
]

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
		event consume.
		event currentTarget removeFromBar ]
	
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

{ #category : #configuration }
ToTabItemElement >> newWidgetConfiguration [ 

	^ ToTabItemElementConfiguration new
]

{ #category : #'t - removable item element' }
ToTabItemElement >> removeButton [

	^ removeButton 
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

{ #category : #'t - removable item element' }
ToTabItemElement >> removeRemoveButton [

	removeButton ifNil: [ ^ self ].
	removeButton removeFromParent.
	removeButton := nil
]
