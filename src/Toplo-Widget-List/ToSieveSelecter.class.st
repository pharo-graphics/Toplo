Class {
	#name : #ToSieveSelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSieveSelecter >> defaultCommandApplicationStrategy [

	" normally not sent "
	^ nil
]

{ #category : #initialization }
ToSieveSelecter >> initializeCommandApplicationStrategy [

	" my command application strategy is the one of my list element primary selecter.
	See ToPrimarySelecter>>newSieveSelecter "
]
