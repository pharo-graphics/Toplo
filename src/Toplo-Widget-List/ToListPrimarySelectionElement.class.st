Class {
	#name : 'ToListPrimarySelectionElement',
	#superclass : 'ToListSelectionElement',
	#instVars : [
		'backgroundElement'
	],
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'accessing' }
ToListPrimarySelectionElement >> backgroundElement [

	^ backgroundElement 
]

{ #category : 'initialization' }
ToListPrimarySelectionElement >> blurEvent: anEvent [

	self backgroundElement background: self theme item selectedBlurredColor
]

{ #category : 'initialization' }
ToListPrimarySelectionElement >> focusEvent: anEvent [

	self backgroundElement background: self theme item selectedColor
]

{ #category : 'secondary selection' }
ToListPrimarySelectionElement >> hideSecondarySelection [

	self padding: (BlInsets all: 0)
]

{ #category : 'initialization' }
ToListPrimarySelectionElement >> initialize [ 

	super initialize.
	backgroundElement := ToElement new matchParent.
	self background: Color transparent.
	backgroundElement background: self theme item selectedColor.
	backgroundElement geometry: self defaultGeometry.
	self addChild: backgroundElement
]

{ #category : 'secondary selection' }
ToListPrimarySelectionElement >> showSecondarySelection [

	self padding: (BlInsets all: 3)
]
