Class {
	#name : 'ToListPrimarySelectionElement',
	#superclass : 'ToListSelectionElement',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
}

{ #category : 'initialization' }
ToListPrimarySelectionElement >> initialize [ 

	super initialize.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : 'skin' }
ToListPrimarySelectionElement >> newRawSkin [ 

	^ ToListPrimarySelectionElementSkin new
]
