Class {
	#name : 'ToTextEmptinessChangeEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Widget-Album-TextPane',
	#package : 'Toplo-Widget-Album',
	#tag : 'TextPane'
}

{ #category : 'sending' }
ToTextEmptinessChangeEvent >> sendTo: anObject [

	anObject textEmptinessChangeEvent: self
]
