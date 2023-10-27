Class {
	#name : 'ToDataEmptinessChangeEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'sending' }
ToDataEmptinessChangeEvent >> sendTo: anObject [

	anObject dataEmptinessChangeEvent: self
]
