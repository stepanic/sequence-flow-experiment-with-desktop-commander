import 'package:flutter/material.dart';
import '../models/entities/index.dart';
import 'ai_chat/ai_chat.dart';
import 'directed_graph/directed_graph.dart';
import 'task_list/task_list.dart';

/// The main layout of the application with three columns:
/// 1. Left: AI chat for guided planning
/// 2. Middle: Interactive directed graph visualization
/// 3. Right: Hierarchical task list and details
///
/// This design allows simultaneous viewing of different aspects of the planning process.
class ThreeColumnLayout extends StatelessWidget {
  /// Current UI state.
  final UIState uiState;

  /// Callback for when the UI state changes.
  final Function(UIState) onUiStateChanged;

  const ThreeColumnLayout({
    Key? key,
    required this.uiState,
    required this.onUiStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left column: AI Chat
        Expanded(
          flex: 3,
          child: AIChat(
            conversationId: uiState.conversationId,
            onMessageSent: (message) {
              // Handle new messages
            },
          ),
        ),
        
        // Divider between left and middle columns
        const VerticalDivider(width: 1, thickness: 1),
        
        // Middle column: Directed Graph
        Expanded(
          flex: 5,
          child: DirectedGraph(
            uiState: uiState,
            onNodeSelect: (nodeId) {
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: uiState.expandedNodeIds,
                selectedTaskId: nodeId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
            onNodeExpand: (nodeId) {
              final updatedExpandedIds = List<String>.from(uiState.expandedNodeIds);
              if (!updatedExpandedIds.contains(nodeId)) {
                updatedExpandedIds.add(nodeId);
              }
              
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: updatedExpandedIds,
                selectedTaskId: uiState.selectedTaskId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
            onNodeCompress: (nodeId) {
              final updatedExpandedIds = List<String>.from(uiState.expandedNodeIds);
              updatedExpandedIds.remove(nodeId);
              
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: updatedExpandedIds,
                selectedTaskId: uiState.selectedTaskId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
          ),
        ),
        
        // Divider between middle and right columns
        const VerticalDivider(width: 1, thickness: 1),
        
        // Right column: Task List
        Expanded(
          flex: 3,
          child: TaskList(
            uiState: uiState,
            onTaskSelect: (taskId) {
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: uiState.expandedNodeIds,
                selectedTaskId: taskId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
            onTaskExpand: (nodeId) {
              final updatedExpandedIds = List<String>.from(uiState.expandedNodeIds);
              if (!updatedExpandedIds.contains(nodeId)) {
                updatedExpandedIds.add(nodeId);
              }
              
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: updatedExpandedIds,
                selectedTaskId: uiState.selectedTaskId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
            onTaskCompress: (nodeId) {
              final updatedExpandedIds = List<String>.from(uiState.expandedNodeIds);
              updatedExpandedIds.remove(nodeId);
              
              final newState = UIState(
                conversationId: uiState.conversationId,
                currentView: uiState.currentView,
                expandedNodeIds: updatedExpandedIds,
                selectedTaskId: uiState.selectedTaskId,
                visibleGraphArea: uiState.visibleGraphArea,
              );
              onUiStateChanged(newState);
            },
          ),
        ),
      ],
    );
  }
}
