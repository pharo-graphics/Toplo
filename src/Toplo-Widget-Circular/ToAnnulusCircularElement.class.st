Class {
	#name : #ToAnnulusCircularElement,
	#superclass : #ToBasicCircularElement,
	#traits : 'TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait',
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #'t - circular element' }
ToAnnulusCircularElement >> defaultLayout [ 

	^ ToAnnulusCircularLayout new 
]

{ #category : #'t - annulus circular layout user' }
ToAnnulusCircularElement >> stateHolder [

	^ self layout
]
