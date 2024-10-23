Class {
	#name : #ToDataSourceCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToDataSourceCommandApplicationStrategy >> addCommand: aCommand [ 

	element isAttachedToSceneGraph ifFalse: [
		commandApplier applyCommand: aCommand.
		^ self ].
	element dataSource
		notifySelecterCommandApplicationRequest: aCommand
		from: commandApplier.
	element spaceDo: [ :sp | sp requestNextPulse ]
]
