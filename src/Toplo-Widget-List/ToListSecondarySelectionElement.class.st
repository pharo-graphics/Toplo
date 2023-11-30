Class {
	#name : 'ToListSecondarySelectionElement',
	#superclass : 'ToListSelectionElement',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'initialization' }
ToListSecondarySelectionElement >> defaultPadding [

	^ BlInsets all: 3
]

{ #category : 'secondary selection' }
ToListSecondarySelectionElement >> hideSecondarySelection [

	self removeFromParent
]

{ #category : 'secondary selection' }
ToListSecondarySelectionElement >> showSecondarySelection [

	" nothing to do "
]
