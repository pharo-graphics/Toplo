Class {
	#name : 'ToListElementContextMenuWindowHandler',
	#superclass : 'ToContextMenuWindowHandler',
	#category : 'Toplo-Widget-List-Context-menu',
	#package : 'Toplo-Widget-List',
	#tag : 'Context-menu'
}

{ #category : 'accessing' }
ToListElementContextMenuWindowHandler >> windowRequestClass [

	^ ToListElementContextMenuRequest
]
