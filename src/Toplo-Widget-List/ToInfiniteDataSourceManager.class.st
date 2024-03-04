Class {
	#name : #ToInfiniteDataSourceManager,
	#superclass : #BlInfiniteDataSourceManager,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #initialization }
ToInfiniteDataSourceManager >> initialize [ 

	super initialize.
	existingCommandTypes := ToInfiniteDataSourceCommandTypeFlags new
]

{ #category : #'as yet unclassified' }
ToInfiniteDataSourceManager >> onOtherCommand: aCommand [ 

	"Register update command"
	
	pendingCommands add: aCommand.
	existingCommandTypes addOther.

	^ true
]
