Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'as yet unclassified' }
ToInfiniteDataSourceManager >> onOtherCommand: aCommand [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"
	pendingCommands add: aCommand.
	^ pendingCommands size >= 1
]
