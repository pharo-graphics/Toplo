Class {
	#name : #ToTripletNode,
	#superclass : #ToTripletElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - clickable - click behavior' }
ToTripletNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - initialization dresser' }
ToTripletNode >> defaultDresser [ 

	^ super defaultDresser next: ToPairedNodeDresser new
]
