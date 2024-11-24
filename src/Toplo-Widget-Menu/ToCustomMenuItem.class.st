Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToCustomMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	"self isSelectable ifTrue: [ ^ self ].
	aMenu itemList unselectableSelecter selectIndex: self positionInMenu"
]

{ #category : #initialization }
ToCustomMenuItem >> constraintInMenuNode: aNode [

	super constraintInMenuNode: aNode.
	self isSelectable ifTrue: [ ^ self ].
	aNode holder listElement unselectableSelecter selectIndex: aNode holder position
	
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement: anElement [

	innerElement := anElement.
	self addChild: anElement
]

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]
