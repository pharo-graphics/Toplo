Class {
	#name : 'ToTabNode',
	#superclass : 'ToNode',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'initialization' }
ToTabNode >> defaultPadding [

	^ (BlInsets top: 1 left: 4 bottom: 1 right: 4)
]
