Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'primarySelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToSecondarySelecter >> primarySelecter: aPrimarySelecter [

	primarySelecter := aPrimarySelecter 
]

{ #category : #accessing }
ToSecondarySelecter >> subSelecterIndex [

	^ primarySelecter subSelecterIndex
]
