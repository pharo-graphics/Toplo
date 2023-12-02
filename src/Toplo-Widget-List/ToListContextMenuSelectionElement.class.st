Class {
	#name : 'ToListContextMenuSelectionElement',
	#superclass : 'ToListSelectionElement',
	#instVars : [
		'inner'
	],
	#category : 'Toplo-Widget-List-Context-menu',
	#package : 'Toplo-Widget-List',
	#tag : 'Context-menu'
}

{ #category : 'initialization' }
ToListContextMenuSelectionElement >> initialize [

	super initialize.
	inner := ToElement new
		         id: #inner;
		         yourself.
	inner matchParent.
	self addChild: inner
]

{ #category : 'accessing' }
ToListContextMenuSelectionElement >> inner [

	^ inner
]

{ #category : 'skin' }
ToListContextMenuSelectionElement >> newRawSkin [ 

	^ ToListContextMenuSelectionElementSkin new
]
