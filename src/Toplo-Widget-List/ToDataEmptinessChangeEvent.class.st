Class {
	#name : 'ToDataEmptinessChangeEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Widget-List-Infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'Infinite'
}

{ #category : 'sending' }
ToDataEmptinessChangeEvent >> sendTo: anObject [

	anObject dataEmptinessChangeEvent: self
]
