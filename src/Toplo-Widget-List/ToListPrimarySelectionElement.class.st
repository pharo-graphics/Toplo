Class {
	#name : #ToListPrimarySelectionElement,
	#superclass : #ToListSelectionElement,
	#category : 'Toplo-Widget-List-Selection'
}

{ #category : #initialization }
ToListPrimarySelectionElement >> initialize [ 

	super initialize.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #skin }
ToListPrimarySelectionElement >> newRawSkin [ 

	^ ToListPrimarySelectionElementSkin new
]
