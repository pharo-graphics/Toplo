Class {
	#name : #ToSelecterCommandApplication,
	#superclass : #BlInfiniteDataSourceCommand,
	#instVars : [
		'command',
		'selecter'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #commands }
ToSelecterCommandApplication >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"
	
	^ aPosition
]

{ #category : #accessing }
ToSelecterCommandApplication >> command [

	^ command
]

{ #category : #accessing }
ToSelecterCommandApplication >> command: aCommand [

	command := aCommand
]

{ #category : #commands }
ToSelecterCommandApplication >> dispatchToLayout: aLayout [


]

{ #category : #commands }
ToSelecterCommandApplication >> offsetPositionsIn: anInfiniteElement [

	selecter applyCommand: command
]

{ #category : #accessing }
ToSelecterCommandApplication >> selecter [

	^ selecter
]

{ #category : #accessing }
ToSelecterCommandApplication >> selecter: aSelecter [

	selecter := aSelecter
]
