Class {
	#name : #ToListNoneSelectionManager,
	#superclass : #ToListAbstractSelectionManager,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToListNoneSelectionManager >> defaultSelectionMode [

	^ ToListNoneSelectionMode new
]

{ #category : #accessing }
ToListNoneSelectionManager >> nodeEventHandlerClasses [ 

	^ {  }

]

{ #category : #'event handling' }
ToListNoneSelectionManager >> onClickOnNode: aNode event: anEvent [


]
