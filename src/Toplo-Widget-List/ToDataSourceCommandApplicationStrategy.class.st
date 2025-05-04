Class {
	#name : #ToDataSourceCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToDataSourceCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	element isAttachedToSceneGraph ifFalse: [
		aCommandApplier applyCommand: aCommand.
		^ self ].
	element dataSourceManager posponeAction: [
		aCommandApplier applyCommand: aCommand ].
	element addedDataSourceCommand: aCommand
]
