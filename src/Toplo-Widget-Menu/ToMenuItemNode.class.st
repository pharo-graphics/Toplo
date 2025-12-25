Class {
	#name : #ToMenuItemNode,
	#superclass : #ToListItemNode,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #configuration }
ToMenuItemNode >> applyConfiguration [

	super applyConfiguration.
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	self holderDo: [ :h |
		h listElement isHorizontal
			ifTrue: [
				self hFitContent ]
			ifFalse: [
				self hMatchParent ] ].
	self vFitContent.
	self item applyConfiguration
]

{ #category : #'t - item node' }
ToMenuItemNode >> newRawSkin [ 

	^ ToMenuItemNodeSkin new
]
