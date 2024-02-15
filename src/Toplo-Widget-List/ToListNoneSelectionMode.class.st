Class {
	#name : #ToListNoneSelectionMode,
	#superclass : #ToListAbstractSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListNoneSelectionMode >> newSelecterIn: anElement [

	^ ToNoneSelectionModelSelecter new 
]

{ #category : #accessing }
ToListNoneSelectionMode >> nodeEventHandlerClasses [ 

	^ {  }

]

{ #category : #'event handling' }
ToListNoneSelectionMode >> onClickEvent: anEvent onNode: aNode [


]
