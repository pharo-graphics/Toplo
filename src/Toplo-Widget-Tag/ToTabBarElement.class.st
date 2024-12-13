Class {
	#name : #ToTabBarElement,
	#superclass : #ToTagBarElement,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - bar element' }
ToTabBarElement >> haveInvisibleNodes: theInvisibleNodes [

	theInvisibleNodes ifEmpty: [ ^ self ].
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	nodeAutoDistribution ifFalse: [ ^ self ].
	" ok the node menu can be shown "
]
