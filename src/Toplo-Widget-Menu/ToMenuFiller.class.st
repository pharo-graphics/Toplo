Class {
	#name : #ToMenuFiller,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToMenuFiller >> applyWidgetConfiguration [
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	super applyWidgetConfiguration.
	self holderDo: [ :h |
		h node matchParent ]
]

{ #category : #initialization }
ToMenuFiller >> initialize [

	super initialize.
	self
		id: #filler;
		matchParent
]

{ #category : #'adding-removing' }
ToMenuFiller >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedFillerMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuFiller >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedFillerMenuItem: self
]
