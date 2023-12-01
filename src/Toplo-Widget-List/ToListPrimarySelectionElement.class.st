Class {
	#name : 'ToListPrimarySelectionElement',
	#superclass : 'ToListSelectionElement',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'initialization' }
ToListPrimarySelectionElement >> blurEvent: anEvent [

	self background: Color lightGray lighter
]

{ #category : 'initialization' }
ToListPrimarySelectionElement >> focusEvent: anEvent [

	self background: Color lightGray
]

{ #category : 'initialization' }
ToListPrimarySelectionElement >> initialize [ 

	super initialize.
	self background: Color lightGray
]
