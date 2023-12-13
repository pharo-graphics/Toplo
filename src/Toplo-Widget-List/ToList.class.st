Class {
	#name : 'ToList',
	#superclass : 'ToListElement',
	#category : 'Toplo-Widget-List-List',
	#package : 'Toplo-Widget-List',
	#tag : 'List'
}

{ #category : 'initialization' }
ToList >> initialize [

	super initialize.
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListElementSelectionEventHandler new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self matchParent
]
