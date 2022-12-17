Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToAbstractMenuItem,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToSeparatorMenuItem >> defaultDresser [ 

	^ ToSeparatorMenuItemDresser new
]

{ #category : #initialization }
ToSeparatorMenuItem >> initialize [ 

	super initialize.
	self initializeDresser 
]
