Class {
	#name : #ToListNoneSelectionMode,
	#superclass : #ToListAbstractSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListNoneSelectionMode >> defaultSelectionCommandChecker [

	^ ToListNoneSelectionCommandChecker new
]

{ #category : #accessing }
ToListNoneSelectionMode >> nodeEventHandlerClasses [ 

	^ {  }

]

{ #category : #'event handling' }
ToListNoneSelectionMode >> onClickOnNode: aNode event: anEvent [


]
