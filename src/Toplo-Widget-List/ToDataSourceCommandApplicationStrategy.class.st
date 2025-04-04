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
	element innerElement dataSourceManager
		onSelecterCommand: aCommand appliedBy: aCommandApplier.
	element innerElement requestLayout
]
