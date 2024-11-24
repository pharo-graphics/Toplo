Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToSeparatorMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.

	aMenu itemList unselectableSelecter selectIndex: self positionInMenu
]

{ #category : #initialization }
ToSeparatorMenuItem >> constraintInMenuNode: aNode [

	super constraintInMenuNode: aNode.
	aNode holder listElement unselectableSelecter selectIndex: aNode holder position.
	aNode holder listElement isHorizontal
		ifTrue: [
			self firstChild constraintsDo: [ :c |
				c vertical exact: 8.
				c horizontal exact: 1 ] ]
		ifFalse: [
			self firstChild constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 1 ] ]
]

{ #category : #initialization }
ToSeparatorMenuItem >> initialize [

	super initialize.
	self addChild: (ToElement new
			 background: Color lightGray;
			 layout: BlLinearLayout new;
			 yourself).
	self padding: (BlInsets all: 2)
]
