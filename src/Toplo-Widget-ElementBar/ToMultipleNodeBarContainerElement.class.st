Class {
	#name : #ToMultipleNodeBarContainerElement,
	#superclass : #ToMultipleSelectionElementBarContainerElement,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToMultipleNodeBarContainerElement >> refresh [
	" first remove all data nodes "
	| detached newNodes |
	detached := OrderedCollection new.
	self nodesDo: [ :node |
		node onUninstalledIn: elementBar.
		detached add: node.
		innerNodeContainer detachChild: node ].
	self nodeHolders reset.
	" then rebuild current nodes according to current selection "
	newNodes := elementBar dataAccessor withIndexCollect: [ :data :idx |
		| node |
		node := self newNode.
		node holder
			position: idx;
			dataItem: data.
		self nodeBuilder value: node value: node holder.
		self nodeHolders add: node holder.
		node ].
	self addAllDataNodes: newNodes.
	detached do: [ :node | innerNodeContainer removeDetachedChild: node].
	scrollable requestLayout
]
