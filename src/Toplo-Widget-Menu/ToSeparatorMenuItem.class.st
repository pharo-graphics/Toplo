Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToSeparatorMenuItem >> applyWidgetConfiguration [
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	super applyWidgetConfiguration.
	self holderDo: [ :h |
		h node matchParent.
		h listElement isHorizontal
			ifTrue: [
				self firstChild constraintsDo: [ :c |
					c vertical exact: 10.
					c horizontal exact: 1 ] ]
			ifFalse: [
				self firstChild constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 1 ] ] ]
]

{ #category : #'t - menu item' }
ToSeparatorMenuItem >> closeOnPicking [ 

	^ false
]

{ #category : #initialization }
ToSeparatorMenuItem >> initialize [

	super initialize.
	self addChild: (ToElement new
			 layout: BlLinearLayout new;
			 yourself).
	self firstChild layout alignCenter.
]

{ #category : #skin }
ToSeparatorMenuItem >> newRawSkin [ 

	^ ToSeparatorMenuItemSkin new
]

{ #category : #'adding-removing' }
ToSeparatorMenuItem >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedSeparatorMenuItem: self
]

{ #category : #'adding-removing' }
ToSeparatorMenuItem >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedSeparatorMenuItem: self
]
