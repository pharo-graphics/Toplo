Class {
	#name : 'ToListContextMenuSelectionElement',
	#superclass : 'ToListSelectionElement',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'initialization' }
ToListContextMenuSelectionElement >> initialize [

	| inner |
	super initialize.
	self outskirts: BlOutskirts outside.
	inner := ToElement new
		         id: #inner;
		         yourself.
	inner matchParent.
	inner layout: BlFrameLayout new.
	inner geometry: self defaultGeometry.
	inner border: (BlBorder paint: Color white width: 2).
	self addChild: inner
]
