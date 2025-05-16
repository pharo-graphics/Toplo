Class {
	#name : #ToSieveSelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSieveSelecter >> defaultCommandApplicationStrategy [

	^ BlImmediateCommandApplicationStrategy new
]
