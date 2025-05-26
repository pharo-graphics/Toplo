Class {
	#name : #ToDataSourceCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToDataSourceCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	element isAttachedToSceneGraph ifFalse: [
		aCommandApplier applyCommand: aCommand.
		^ self ].
	element posponeAction: [
		aCommandApplier applyCommand: aCommand ].
	element addedDataSourceCommand: aCommand
]
