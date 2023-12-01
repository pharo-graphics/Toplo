Class {
	#name : 'ToList',
	#superclass : 'ToListElement',
	#category : 'Toplo-Widget-List-list',
	#package : 'Toplo-Widget-List',
	#tag : 'list'
}

{ #category : 'initialization' }
ToList >> initialize [

	super initialize.
	self contextMenuWindowHandlerClass: ToListElementContextMenuWindowHandler.
	self addEventHandler: ToListElementSelectionEventHandler new.
	self addEventHandler: ToListElementContextMenuSelectionEventHandler new.
	self matchParent
]
