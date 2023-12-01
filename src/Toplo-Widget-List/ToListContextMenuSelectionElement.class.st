Class {
	#name : 'ToListContextMenuSelectionElement',
	#superclass : 'ToListSelectionElement',
	#instVars : [
		'inner'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
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
