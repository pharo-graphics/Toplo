Class {
	#name : #ToListNoneSelectionMode,
	#superclass : #ToListAbstractSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListNoneSelectionMode >> isMultipleSelection [

	^ false
]

{ #category : #'instance creation' }
ToListNoneSelectionMode >> newSelecter [

	^ ToNoneSelectionModelSelecter new 
]

{ #category : #accessing }
ToListNoneSelectionMode >> nodeEventHandlerClasses [ 

	^ {  }

]

{ #category : #'event handling' }
ToListNoneSelectionMode >> onClickEvent: anEvent onNode: aNode [


]
