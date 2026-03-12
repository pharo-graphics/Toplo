Class {
	#name : #ToSelecterDataSourceCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToSelecterDataSourceCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	element isAttachedToSceneGraph ifFalse: [
			aCommandApplier applyCommand: aCommand.
			^ self ].

	element postponeCommand: (ToListSelectionCommand new
			 applier: aCommandApplier;
			 command: aCommand;
			 yourself).
	element addedDataSourceCommand: aCommand
]

{ #category : #testing }
ToSelecterDataSourceCommandApplicationStrategy >> hasPendingCommands [

	^ element innerElement dataSourceManager hasFinalStepCommand
]
